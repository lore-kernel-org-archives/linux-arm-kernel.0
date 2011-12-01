From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Thu, 01 Dec 2011 14:52:10 +0400
Subject: [PATCH] arm: add default value for PHYS_OFFSET Kconfig setting
In-Reply-To: <1322711557-8279-1-git-send-email-paul.gortmaker@windriver.com>
References: <1322711557-8279-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <4ED75C5A.4070508@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01.12.2011 7:52, Paul Gortmaker wrote:

> Commit 1b9f95f8ade9efc2bd49f0e7b9dc61a038ac3eef introduced the new

    Please also cite that commit's summary in parens.

> Kconfig for PHYS_OFFSET but it did not specify a default value.

> This has the undesired side effect of breaking an implictly used
> trick for updating defconfigs on the fly for routine buildtesting
> across all arch and all platforms, i.e.

>    cp /path/to/somedefconfig .config ; yes "" | make oldconfig

> In particular, the at91x40_defconfig will enter an infinite loop
> with the above, since there is no default value, and conf will just
> keep asking for one, and "yes" will keep feeding in a line return.

> Signed-off-by: Paul Gortmaker<paul.gortmaker@windriver.com>

WBR, Sergei
