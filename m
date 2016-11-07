From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Mon, 7 Nov 2016 20:47:25 +0800
Subject: [PATCH next 1/2] media: mtk-mdp: fix video_device_release argument
In-Reply-To: <dbaa8b70-ea72-7d9b-176c-6c0a816aaae8@xs4all.nl>
References: <1473340146-6598-4-git-send-email-minghsiu.tsai@mediatek.com>
 <20161027202325.20680-1-vincent.stehle@laposte.net>
 <20161028075253.gdy2bbugih6oqncw@romuald.bergerie>
 <dbaa8b70-ea72-7d9b-176c-6c0a816aaae8@xs4all.nl>
Message-ID: <1478522845.4269.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-11-03 at 13:47 +0100, Hans Verkuil wrote:
> Hi Vincent,
> 
> On 28/10/16 09:52, Vincent Stehl? wrote:
> > On Thu, Oct 27, 2016 at 10:23:24PM +0200, Vincent Stehl? wrote:
> >> video_device_release() takes a pointer to struct video_device as argument.
> >> Fix two call sites where the address of the pointer is passed instead.
> >
> > Sorry, I messed up: please ignore that "fix". The 0day robot made me
> > realize this is indeed not a proper fix.
> >
> > The issue remains, though: we cannot call video_device_release() on the
> > vdev structure member, as this will in turn call kfree(). Most probably,
> > vdev needs to be dynamically allocated, or the call to
> > video_device_release() dropped completely.
> 
> I prefer that vdev is dynamically allocated. There are known problems with
> embedded video_device structs, so allocating it is preferred.
> 
> Minghsiu, can you do that?
> 

Hi Hans,

I just send the patch for this.
https://patchwork.kernel.org/patch/9415007/


> Regards,
> 
> 	Hans
> 
> >
> > Sorry for the bad patch.
> >
> > Best regards,
> >
> > Vincent.
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-media" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
