From: broonie@kernel.org (Mark Brown)
Date: Fri, 31 Jan 2014 16:03:28 +0000
Subject: [PATCH v2 3/5] spi: sunxi: Add Allwinner A31 SPI controller driver
In-Reply-To: <20140131081147.GC2950@lukather>
References: <1390993850-9054-1-git-send-email-maxime.ripard@free-electrons.com>
 <1390993850-9054-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140129122520.GY11841@sirena.org.uk>
 <20140129133227.GQ3867@lukather>
 <CAGa+x854huSmiWmEv2EgOPUgZKcp3iitNaBvKXt8DiEj8msSVg@mail.gmail.com>
 <20140131081147.GC2950@lukather>
Message-ID: <20140131160328.GI22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 09:11:47AM +0100, Maxime Ripard wrote:

> Wouldn't it be better if it was suspended by default, and just waken
> up whenever the framework needs it?

The aim should be to come out of probe in that state if runtime PM is
enabled but don't do it with these hacks, do it by idling the device
at the end of probe for example.  Apart from anything else this code
just looks ugly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/2482bece/attachment.sig>
