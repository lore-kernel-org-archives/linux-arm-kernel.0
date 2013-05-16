From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 May 2013 18:26:05 +0100
Subject: [PATCH RFC] clk: Introduce userspace clock driver
In-Reply-To: <5194F0C0.9020609@balister.org>
References: <0bf5a185-86f7-4a93-a90f-42caefb06a1d@TX2EHSMHS009.ehs.local>
 <519112F9.2010102@gmail.com>
 <7c5e7537-6ed5-4622-a7a9-bf46820ef695@VA3EHSMHS033.ehs.local>
 <519124D3.2040403@gmail.com>
 <af51c63e-7ff1-4e73-9305-08309217ab38@TX2EHSMHS037.ehs.local>
 <20130514164611.10068.46384@quantum>
 <51927DEB.7090001@balister.org>
 <20130515044604.GA24524@sirena.org.uk>
 <51946082.1000606@codeaurora.org> <5194F0C0.9020609@balister.org>
Message-ID: <20130516172605.GB1627@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 10:44:16AM -0400, Philip Balister wrote:
> On 05/16/2013 12:28 AM, Saravana Kannan wrote:

> > Agreed. I was about to reply with exactly the same point. I haven't done
> > any UIO coding, but that device file will eventually have to be opened.
> > Turn on the clocks in the open and turn them off at close.

> > Rate to request can be a DT property.

> But you are assuming each device implemented in the fpga uses one clock.
> This assumption is clearly not valid since devices will ahve to share
> clocks.

The binding should obviously be defined as a set of clocks rather than a
single clock - something like how we specify regulators on PMICs
probably makes sense.  Each clock can have its own properties.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130516/fbd7938b/attachment-0001.sig>
