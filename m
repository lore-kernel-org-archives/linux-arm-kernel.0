From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 1 Dec 2011 08:14:26 +0200
Subject: [RFC] virtio: use mandatory barriers for remote processor vdevs
In-Reply-To: <20111130231306.GD30031@redhat.com>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
 <20111129131110.GC19157@redhat.com>
 <CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
 <20111129151958.GA31789@redhat.com>
 <CAK=WgbZ5aBFNro3XC0cN+Ao4ZWrBHwwd3d__CSHA=n56gKmKXw@mail.gmail.com>
 <20111130145004.GD21413@redhat.com>
 <CAK=WgbY59n9N_-2_TZ9wNBNcTMV1DCrz65e-Ae=xamcg6A0dOA@mail.gmail.com>
 <20111130231306.GD30031@redhat.com>
Message-ID: <CAK=Wgbb5M62LgXY-sn7R6YautHxwqyDbPTeXYJxgmrS9fPXR9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 1, 2011 at 1:13 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> For x86, stores into memory are ordered. So I think that yes, smp_XXX
> can be selected at compile time.

But then you can't use the same kernel image for both scenarios.

It won't take long until people will use virtio on ARM for both
virtualization and for talking to devices, and having to rebuild the
kernel for different use cases is nasty.
