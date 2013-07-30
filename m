From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 30 Jul 2013 07:20:47 -0700
Subject: [linux-sunxi] Re: [PATCH 1/2] Initial support for Allwinner's
 Security ID fuses
In-Reply-To: <51F7BE2F.3060004@schinagl.nl>
References: <20130626175144.GC2222@kroah.com> <51D674BF.9030207@schinagl.nl>
 <20130706193646.GB9778@kroah.com> <51E466A3.4010503@schinagl.nl>
 <20130716064107.GA10868@kroah.com> <20130717114650.GN3125@lukather>
 <20130717161758.GA9822@kroah.com> <20130719094211.GD5106@lukather>
 <20130719234944.GA11498@kroah.com> <51F7BE2F.3060004@schinagl.nl>
Message-ID: <20130730142047.GA28696@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 03:22:55PM +0200, Oliver Schinagl wrote:
> >Let me go look at how I can make this work "easier", give me a few days.
> Not wanting to be rude, but it has been a little more then a few
> days, any progress? Just want to know what I have to modify my
> driver to so it can go into the next merge window :)

What?  Oh crap.

I saw this old email in my todo box last week and for some stupid reason
I thought I had already taken care of this, otherwise why would I have
left it around for so long?...

Ugh, very sorry about that...

Hm, this is a mess.  I hate platform devices...

Anyway, as you want to get this into 3.12, and I'm not going to be able
to get the core infrastructure into the platform device by then, just go
ahead and do a sysfs_create_group() call in your device probe callback
for now.  That will register the needed files for the device (not the
driver, DOH that was stupid of me...) and all should be ok.

Yes, you will still race with userspace, but as right now, there's no
way that _any_ platform driver can do this "correctly", you will be in
good company.  I'll clean up all platform drivers in a sweep of the tree
after 3.12 or so when I get the needed infrastructure in place for the
platform_driver code.

Again, very sorry for all of this, you have helped me out a lot in
figuring out that this is a mess, and should be fixed up better, but in
the end, you are pretty much back at the beginning of what you
originally wanted to do, right?

I owe you a beer, at the least, my apologies...

greg k-h
