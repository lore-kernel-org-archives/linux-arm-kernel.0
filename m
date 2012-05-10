From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 May 2012 10:42:06 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <1336621458.1540.280.camel@vkoul-udesk3>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
 <20120509093334.GS26481@n2100.arm.linux.org.uk>
 <20120509111614.GH3955@opensource.wolfsonmicro.com>
 <20120509121945.GT26481@n2100.arm.linux.org.uk>
 <1336621458.1540.280.camel@vkoul-udesk3>
Message-ID: <20120510094205.GM3908@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 09:14:18AM +0530, Vinod Koul wrote:

> For audio needs I think it is fine if we miss, as long as subsequent
> comes untill we get underrun/overrun.

No, - this is what Russell has been reporting.  Due to the lack of
position callbacks the ASoC dmaengine stuff is counting completions to
work out where it is in the buffer.  If we miss completions then the
drivers will start to loose track of where they are in the buffer.  If
we had usable position reporting this would work OK, or if the ASoC code
were changed to remember where each buffer ends and get that information
passed back in the completion argument then it could recover that way
(but that's fairly painful).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120510/4ade4fa9/attachment.sig>
