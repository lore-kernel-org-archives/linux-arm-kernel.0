From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 10 Dec 2016 10:19:07 +0100
Subject: [PATCH V1] pinctrl:pxa:pinctrl-pxa2xx:- No need of devm functions
In-Reply-To: <1481207730-6332-1-git-send-email-arvind.yadav.cs@gmail.com>
 (Arvind Yadav's message of "Thu, 8 Dec 2016 20:05:30 +0530")
References: <1481207730-6332-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <87eg1g16r8.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arvind Yadav <arvind.yadav.cs@gmail.com> writes:

Hi Arvind,

> In functions pxa2xx_build_functions, the memory allocated for
> 'functions' is live within the function only. After the
> allocation it is immediately freed with devm_kfree. There is
> no need to allocate memory for 'functions' with devm function
> so replace devm_kcalloc  with kcalloc and devm_kfree with kfree.

That's not very true : the "need" is to spare the "manual" kfree you're adding
in your patch for one, and make it consistent with pxa2xx_build_groups() and
pxa2xx_build_state() for two.

Therefore I'm not very thrilled by this patch and unless it fixes a defect in
the driver I'd rather not have it in.

Cheers.

--
Robert
