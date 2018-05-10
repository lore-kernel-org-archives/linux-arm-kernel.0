From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 May 2018 07:47:03 -0700
Subject: Spectre and Cortex-A8/A9
In-Reply-To: <CAHCN7x+ghEW__YwgbXYO4g9HNKkwkQtXiswL1jihj0wwfKuR4Q@mail.gmail.com>
References: <CAHCN7x+ghEW__YwgbXYO4g9HNKkwkQtXiswL1jihj0wwfKuR4Q@mail.gmail.com>
Message-ID: <20180510144703.GD98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Adam Ford <aford173@gmail.com> [180509 18:23]:
> There is a lot of information pushed around the web about the Spectre
> bug.  I went to ARM's support site and there are some patches
> available from February that haven't made their way into the mainline.
> 
> Sorry if this has been covered before, but I am curious to know if
> there is a good place or method to determine whether or not the
> Cortex-A8 and A9 are still vulnerable and which versions or 4.4, 4.9,
> or 4.14 have any items fixed.

Well while we're waiting to figure out what all needs to be fixed,
here's what I'd do meanwhile:

1. Make sure the bootloader sets IBE bit

2. Make sure you have CONFIG_ARM_ERRATA_430973=y

3. Apply Marc Zyngier's patches from thread "[PATCH v4 0/6] 32bit ARM
   branch predictor hardening", but note that these are still being
   discussed

4. Update kernel when patches that have been validated against
   test cases get merged

Regards,

Tony
