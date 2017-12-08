From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 8 Dec 2017 09:55:33 +0100
Subject: [RFC PATCH 1/6] drm: Add Content Protection property
In-Reply-To: <20171207143052.533e1e94@alans-desktop>
References: <20171130030907.26848-1-seanpaul@chromium.org>
 <20171130030907.26848-2-seanpaul@chromium.org>
 <20171205102840.GB12982@amd>
 <20171205104538.b4fxdjad3c46koas@phenom.ffwll.local>
 <20171207143052.533e1e94@alans-desktop>
Message-ID: <20171208085533.ekzgow4svhw7xnqz@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 02:30:52PM +0000, Alan Cox wrote:
> > If you want to actually lock down a machine to implement content
> > protection, then you need secure boot without unlockable boot-loader and a
> > pile more bits in userspace. 
> 
> So let me take my Intel hat off for a moment.
> 
> The upstream policy has always been that we don't merge things which
> don't have an open usable user space. Is the HDCP encryption feature
> useful on its own ? What do users get from it ?
> 
> If this is just an enabler for a lump of binary stuff in ChromeOS then I
> don't think it belongs, if it is useful standalone then it seems it does
> belong ?

The cros side is ofc all open source. dri-devel is extremely strict with
not taking anything that doesn't fullfil this requirement, probably more
strict than anyone else. Sean has the link in the cover letter of his
patch series.

For more context, here's our documented expectations about the userspace
side of any uapi addition to drm:

https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
