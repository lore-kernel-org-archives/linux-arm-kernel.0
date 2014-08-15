From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 15 Aug 2014 17:02:58 +0100
Subject: [PATCH 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <77e80a2d69ee470a8458a85450a1510c@BY2PR0301MB0743.namprd03.prod.outlook.com>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
 <1408096156-29772-5-git-send-email-bhupesh.sharma@freescale.com>
 <20140815102329.GB596@leverpostej>
 <c43739ed82a34f6eb2adbbe240e07c5d@DM2PR03MB317.namprd03.prod.outlook.com>
 <0DC5667C-E45A-4781-9AE6-0C5E1C70F268@codeaurora.org>
 <9c8daab7efa446c884409ae3aaaaa151@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <3537CF6F-9BF9-4905-B051-EB94034FC1C2@codeaurora.org>
 <77e80a2d69ee470a8458a85450a1510c@BY2PR0301MB0743.namprd03.prod.outlook.com>
Message-ID: <20140815160258.GF18863@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 04:49:53PM +0100, Stuart Yoder wrote:
> > On Aug 15, 2014, at 10:41 AM, Stuart Yoder <stuart.yoder@freescale.com> wrote:
> > > So we want to do the standard/conventional thing here that will
> > > allow are device trees to be used in more than u-boot.
> > 
> > Well, I think the guys would say the standard thing is to move to PSCI.
> 
> Agree.  That is our plan.  But it looks like at this point in
> time all the device tree have a common denominator spin table
> mechanim that gets updated/overriden if PSCI is supported.

That's for historical reasons because at the time there was no PSCI and
now we have to preserve backwards compatibility with older boot
wrappers. The only hardware currently having a DT in the arm64 tree is
the APM one which cannot implement PSCI because there is no EL3.

(and I think we should really get a proper arm64 PSCI implementation in
U-Boot)

-- 
Catalin
