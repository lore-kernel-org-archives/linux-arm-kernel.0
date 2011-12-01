From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 1 Dec 2011 08:20:59 +0200
Subject: [RFC] virtio: use mandatory barriers for remote processor vdevs
In-Reply-To: <20111130234318.GC31069@redhat.com>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
 <20111129131110.GC19157@redhat.com>
 <CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
 <20111129151607.GE30966@redhat.com>
 <CAK=WgbZK+k4uuyMPHUfr_PMyrR5ceRTvuDRpmhXfgwpSUOPw0g@mail.gmail.com>
 <20111130145958.GE21413@redhat.com>
 <CAK=WgbYyFdLftE_kp2_JOThVhn-FzGsDqVqKn0Jwm2teQyZBNA@mail.gmail.com>
 <20111130161555.GB25812@redhat.com>
 <CAK=WgbazBq4GVo16sZsrZirgMYbwMcWtPaqn90c6d9Phr0gh3A@mail.gmail.com>
 <CAK=WgbbZH3ZFzbwwyVBGEvwHPbogDW6+Kb_1pRam2jj5oJHuDA@mail.gmail.com>
 <20111130234318.GC31069@redhat.com>
Message-ID: <CAK=WgbYysMUQjWmgZhHBQJxcyG_J8H-f8FzZwSOVuTRjPRAiUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 1, 2011 at 1:43 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> And these accesses need to be ordered with DSB? Or DMB?

DMB (i.e. smp barriers) should be enough within Normal memory
accesses, though the other issues that were reported to me are a bit
concerning. I'm still trying to get more information about them, in
the hopes that I can eventually reproduce them myself.
