From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 23 Sep 2013 16:59:59 +0400
Subject: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
In-Reply-To: <523FEFC2.801@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379595943-14622-9-git-send-email-rogerq@ti.com>
 <20130922165817.GD30946@htj.dyndns.org> <523F35E4.6050707@cogentembedded.com>
 <20130922215107.GD27616@mtj.dyndns.org> <523FEFC2.801@ti.com>
Message-ID: <52403B4F.3070406@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 23-09-2013 11:37, Roger Quadros wrote:

>>>     Not sure why you asked -- I'm not using this driver, neither I'm

>> Well, you have better grip of what's going on in the embedded world
>> than me.  I'm mostly curious whether adding dependency on PHY is okay.

> There is no hard dependency on presence of PHY. The driver will continue
> as usual if devm_phy_get() fails.
> I hope selecting GENERIC_PHY in Kconfig is not an issue.

    Selecting in the AHCI_PLATFORM section? It seems I have overlooked it. No, 
I don't think it's a good idea. The generic PHY functions seem to be stubbed 
when GENERIC_PHY=n.

> cheers,
> -roger

WBR, Sergei
