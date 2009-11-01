From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Sun, 01 Nov 2009 17:44:42 +0000
Subject: Soc camera:Is there anyone dealing with ov9650chip?Let's talk
	about 	soc camera driver.
In-Reply-To: <65c69abb0910300528j2bffc2b8i8eb07254725f8de7@mail.gmail.com>
References: <65c69abb0910300528j2bffc2b8i8eb07254725f8de7@mail.gmail.com>
Message-ID: <4AEDC90A.7050005@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dean_go Zhang wrote:
> I'm reading to documentation in linux-2.6.30,and ov7670 driver ,and I'm
> trying to make a driver for ov9650.
> 
>     struct soc_camera_ops provides .probe and .remove methods, which are
>     called by
>     the soc-camera core, when a camera is matched against or removed
>     from a camera
>     host bus, .init, .release, .suspend, and .resume are called from the
>     camera host
>     driver as discussed above. Other members of this struct provide
>     respective V4L2
>     functionality.
> 
>  
> This is from the documentation,but I didn't find any thing about
> soc_camera_host_device in ov7670's driver code.
> Does anyone know how to make a v4l2 soc camera driver? 
This isn't really an arm related question.  Should really be asked on
linux-media. (now cc'd along with Guennadi)

Having said that...

The reason you aren't finding soc camera related stuff in the ov7670 driver
is that it isn't currently a soc camera driver.  There is ongoing work to
move the soc-camera framework fully over to using v4l2-subdevs thus allowing
drivers like this one to work both with soc-camera interfaces and others.

There are still a few elements being cleaned up (primarily to do with
negotiation of image formats) that make it tricky for a single driver to
directly support use through soc camera and without it. 

I would suggest looking in the linux-media archive for
Guennanadi Liakhovetski's latest imagebus patches for what still needs doing.

In meantime, the following patch against 2.6.32-rc5 adds soc camera support to the
ov7670 driver.  I've been posting updates tracking Guennadi's changes to soc camera
to linux-media (though I haven't had a chance to do the recent imagebus changes yet).

Unfortunately omnivision aren't exactly free with datasheets (I can get the ov9650 from
google but not the ov9640), so I can't check, but based purely on numbering how does
this chip compare to the ov9640 which as a driver in kernel (probably in a queue
for next merge window? - it's certainly in the tree Guennadi is using and has been
posted to linux-media)

Google did however give me this hit, which mentions an ov9650 driver
http://marex-hnd.blogspot.com/2009/08/omnivision-ov9640-hacking-part-iv.html
Perhaps Guennadi has more info on this?
