From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Dec 2017 09:35:39 +0100
Subject: [PATCH 0/8] drm/sun4i: Support the Display Engine frontend
In-Reply-To: <407ed605-6c02-fae5-7cc8-e6119b26d49f@vitsch.nl>
References: <1513181781-0808628882.0a9bc10eb7@prakkezator.vehosting.nl>
 <407ed605-6c02-fae5-7cc8-e6119b26d49f@vitsch.nl>
Message-ID: <20171214083539.o3wzr5h6yrodygvu@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, Dec 13, 2017 at 05:16:22PM +0100, Thomas van Kleef wrote:
> Hi,
> 
> On 13-12-17 16:33, Maxime Ripard wrote:
> > Hi,
> > 
> > This is a first serie to enable the display engine frontend.
> > 
> > This hardware block is found in the first generation Display Engine from
> > Allwinner. Its role is to implement more advanced features that the
> > associated backend, even though the backend alone can be used (and was used
> > so far) for basic composition.
> > 
> > Among those features, we will find hardware scaling, that is supported in
> > this serie, colorspace conversions, or more exotic formats support such as
> > the one output by the VPU.
>
> So, if I have read the code correctly. The frontend will be used whenever the
> input size differs from the output size.

Yes :)

My current plan is to extend it as needed when we'll need to deal with
a format not supported by the backend (for the VPU), or anything the
backend cannot support.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171214/795427a7/attachment-0001.sig>
