From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Apr 2015 17:09:11 +0100
Subject: [PATCH v3 2/2] arch: arm: Show the serial number from devicetree
 in cpuinfo
In-Reply-To: <1430145747.3081.5.camel@collins>
References: <1429351135-11842-1-git-send-email-contact@paulk.fr>
 <1429351135-11842-2-git-send-email-contact@paulk.fr>
 <CAL_JsqKkw7n5p1ZH345BeKkyU=GKDrhaLef__0ET7t90Cm0Eog@mail.gmail.com>
 <1430145747.3081.5.camel@collins>
Message-ID: <20150428160910.GE12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 27, 2015 at 04:42:27PM +0200, Paul Kocialkowski wrote:
> Well, of_property_read_string is only defined when CONFIG_OF is set
> (base.c is always built in drivers/of but the directory is only included
> when CONFIG_OF is set).
> 
> Of course, on ARM, we now expect that it is the case, but it seems like
> good practice to check for it, since it could theoretically be disabled.

That is _not_ "is the case" - there are a number of non-OF platforms...
including some which will probably never be converted.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
