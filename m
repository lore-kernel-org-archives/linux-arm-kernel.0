From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Dec 2016 13:49:06 +0100
Subject: [PATCH V1] pinctrl:pxa:pinctrl-pxa2xx:- No need of devm functions
In-Reply-To: <1481207730-6332-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1481207730-6332-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <CACRpkdY8mwHD1yyHZSHsDsJNPjrgLTfEok38FNons6oabn5ZPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 8, 2016 at 3:35 PM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> In functions pxa2xx_build_functions, the memory allocated for
> 'functions' is live within the function only. After the
> allocation it is immediately freed with devm_kfree. There is
> no need to allocate memory for 'functions' with devm function
> so replace devm_kcalloc  with kcalloc and devm_kfree with kfree.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

I want the maintainer Robert Jarzmik to review this before I do anything
with it.

Yours,
Linus Walleij
