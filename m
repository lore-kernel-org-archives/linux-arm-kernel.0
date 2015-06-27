From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sat, 27 Jun 2015 23:39:31 +0200
Subject: [PATCH 1/2] ARM: BCM: Do not select CONFIG_MTD_NAND_BRCMNAND
In-Reply-To: <1435422344-31059-2-git-send-email-f.fainelli@gmail.com>
References: <1435422344-31059-1-git-send-email-f.fainelli@gmail.com>
 <1435422344-31059-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <CACna6rz52zv5QBewf8rc6BbJHbAn0-D420dSQe=SBXGef4Birw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 June 2015 at 18:25, Florian Fainelli <f.fainelli@gmail.com> wrote:
> This reverts 7dc95b40f599293aedf30432749ad25b51549041 ("ARM: BCM: Enable
> NAND support for iProc SoCs") since it creates an unmet dependency for
> MTD_NAND_BRCMNAND which depends on MTD and MTD_NAND, this results in the
> following build failure for brcmnand:

This commit message doesn't make too much sense to me. If
MTD_NAND_BRCMNAND really depends on MTD and MTD_NAND then there
couldn't be this problem you described.

Maybe MTD_NAND_BRCMNAND is *missing* that dependency?
