From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 6 Nov 2012 09:53:09 +0100
Subject: [Patch v2 3/4] ASoC: atmel-ssc-dai: register platform from DAIs
In-Reply-To: <5098A280.7070301@atmel.com>
References: <1351668420-18447-1-git-send-email-voice.shen@atmel.com>
 <1351668420-18447-3-git-send-email-voice.shen@atmel.com>
 <20121101144315.GM4413@opensource.wolfsonmicro.com>
 <5093312D.4070408@atmel.com>
 <20121102142444.GY4413@opensource.wolfsonmicro.com>
 <50974DE6.50506@atmel.com> <5098A280.7070301@atmel.com>
Message-ID: <20121106085309.GD5044@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 01:39:12PM +0800, Bo Shen wrote:
> On 11/5/2012 13:25, Bo Shen wrote:

Note that there's less than 24 hours between these two mails...

> >Sorry for misunderstand. I split your e-mail into two parts. May be you
> >miss some parts of my e-mail. You can check the last mail from me. Or
> >check the following fully quote.

> Anyway, I will sent out a RFC patch series (which will be v3) which
> register dai and platform directly in Linux.

> > > This seems to be a purely virtual device which remaps the SSC onto the
> > > Linux audio subsystem?  If that is the case then it shouldn't appear in
> > > the device tree,

> >Yes. This is a purely virtual device. I add this as to the following
> >reason.

> >In our case, the ssc can connect to audio codec, DAC and other devices.
> >In order to avoid duplicate the code, so keep ssc as a library, register
> >it directly in Linux and use remap method to let it work onto other
> >different subsystem.

The whole point here is that this remapping shouldn't appear in the
device tree since it's a purely Linux internal issue, the code that uses
the SSC should have a reference to the SSC and then do whatever
remapping is required.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121106/b4fff9ac/attachment.sig>
