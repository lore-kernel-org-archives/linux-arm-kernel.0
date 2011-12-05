From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Dec 2011 14:37:27 +0000
Subject: [RFC PATCH v1 5/7] media: v4l2: introduce two IOCTLs for face
 detection
In-Reply-To: <CACVXFVO5Bu8vTfLN_WFsEkHW6JhQFmWPmEyNnrvTsDhoF-WVeA@mail.gmail.com>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com>
 <42689146.OPtqLboC2m@wuerfel>
 <CACVXFVO5Bu8vTfLN_WFsEkHW6JhQFmWPmEyNnrvTsDhoF-WVeA@mail.gmail.com>
Message-ID: <201112051437.27538.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 04 December 2011, Ming Lei wrote:
> >
> > This data structure is not 32/64 bit safe: running a 64 bit kernel with 32 bit
> > user space will see an incompatible layout.
> 
> I agree that this is not 32/64 bit safe, but I understand lib32 can handle
> this correctly, otherwise many 32bit applications can't run on current
> 64bit kernel
> since many kernel structures used by user space contained pointer,
> such as struct v4l2_buffer, struct v4l2_ext_controls in v4l2 ABI.

The other ones you mentioned are handled in the kernel in
drivers/media/video/v4l2-compat-ioctl32.c. For new ioctl commands,
it's better to define the data structure in a compatible way
so you do not need a wrapper like that.

	Arnd
