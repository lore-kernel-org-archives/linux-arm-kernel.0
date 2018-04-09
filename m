From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Apr 2018 11:50:01 +0100
Subject: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
In-Reply-To: <94a394bd-89bf-9334-c500-4cbadf4c1044@orpaltech.com>
References: <20180404065048.n76r3ytuznd6fqsl@flea>
 <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
 <20180405091913.ky4dnmszoobn2xry@flea>
 <ee4adb1e-caf6-32f6-33d6-d8dd94d232cf@orpaltech.com>
 <20180405131735.GB12349@sirena.org.uk>
 <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
 <20180406073441.xesojvzc3deljhoy@flea>
 <204e97cb-2f39-00f0-fd4e-3aa9a51f7cac@orpaltech.com>
 <20180409092730.2moyhl5aaktjwbyn@flea>
 <94a394bd-89bf-9334-c500-4cbadf4c1044@orpaltech.com>
Message-ID: <20180409105001.GC11532@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 01:26:23PM +0300, Sergey Suloev wrote:
> On 04/09/2018 12:27 PM, Maxime Ripard wrote:
> > On Fri, Apr 06, 2018 at 06:48:23PM +0300, Sergey Suloev wrote:
> > > On 04/06/2018 10:34 AM, Maxime Ripard wrote:

> > > According to what you said the driver must implement
> > > "transfer_one_message" instead of "transfer_one"

> > I'm not sure what makes you think that I said that.

> Because current implementation tries to send more than FIFO-depth of data in
> a single call to "transfer_one" which is wrong.

No, that's absolutely not the case.  All any of these functions has to
do is transfer whatever they were asked to, how they do it is not at all
important to the framework.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180409/392f06a1/attachment.sig>
