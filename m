From: xhpohanka@gmail.com (Jan Pohanka)
Date: Wed, 24 Aug 2011 15:45:02 +0200
Subject: dma buffers for camera
Message-ID: <op.v0p0hctkyxxkfz@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

could please anyone explain me a bit situation about using memory buffers  
for dma for video input devices? Unfortunately I don't understand it at  
all.
I want to capture images 1600x1200 from 2 mpix sensor on i.mx27 board.
I gave 8MB to mx2_camera device with dma_declare_coherent_memory.

Unfortunately it seems to be not enough. In UYVY format I need 1600x1200x2  
for one picture, it is cca 3.8MB.
After some digging I noticed, that dma_alloc_coherent() is called three  
times and each time with the 3.8MB demand. Once it is directly from  
mx2_camera driver and two times from videobuf_dma_contig. OK, that is more  
than 8MB available, but why there are so big memory demands for one  
picture?

I'm using gstremer for capturing, so it probably requests several buffers  
with VIDIOC_REQBUFS. Is this behaviour normal, even if there is explicitly  
noted that I want only one buffer?

gst-launch \
   v4l2src num-buffers=1 device=/dev/video1 ! \
   video/x-raw-yuv,format=\(fourcc\)UYVY,width=$WIDTH,height=$HEIGHT ! \
   jpegenc ! \
   filesink location=col_image.jpg


with best regards
Jan


-- 
Tato zpr?va byla vytvo?ena p?evratn?m po?tovn?m klientem Opery:  
http://www.opera.com/mail/
