From: rusty@rustcorp.com.au (Rusty Russell)
Date: Sat, 24 Dec 2011 13:31:14 +1030
Subject: [RESENDx2] [PULL] virtio: fix barriers for virtio-mmio
In-Reply-To: <CAK=WgbacH1tXHJiHNKLNNsFA7-vnFT_J6vYOANh0wzGyUj8Zpg@mail.gmail.com>
References: <8739cbkgv2.fsf@rustcorp.com.au>
 <CA+55aFyvMkAtXPRxiFR+UpZKGHMhp8Vd9aYg1dkaoKMwD5MLcw@mail.gmail.com>
 <CA+55aFzKU0GWqpQo2AzAawoVm=qPaJiwKTcifeYApyZP_Hj3nQ@mail.gmail.com>
 <CAK=WgbacH1tXHJiHNKLNNsFA7-vnFT_J6vYOANh0wzGyUj8Zpg@mail.gmail.com>
Message-ID: <87pqfeisg5.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Dec 2011 13:35:26 +0200, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Fri, Dec 23, 2011 at 11:35 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On x86, there really is never any reason to use the heavy memory
> > barriers unless you are talking to a real device. And last I saw,
> > "virtio" was still about virtual IO.

Not any more, as the commit message describes.

But I missed that they're using rpmsg, which isn't merged yet.

Sorry for the noise,
Rusty.
PS. Switching barriers by bus type is too crude anyway, let's come up
    with something better...
