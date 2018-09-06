From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Sep 2018 11:05:43 +0100
Subject: [PATCH v6 00/18] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <20180905141032.b1ddaab53d1b2b3bada95415@linux-foundation.org>
References: <cover.1535462971.git.andreyknvl@google.com>
 <20180905141032.b1ddaab53d1b2b3bada95415@linux-foundation.org>
Message-ID: <20180906100543.GI3592@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 02:10:32PM -0700, Andrew Morton wrote:
> On Wed, 29 Aug 2018 13:35:04 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
> 
> > This patchset adds a new mode to KASAN [1], which is called KHWASAN
> > (Kernel HardWare assisted Address SANitizer).
> 
> We're at v6 and there are no reviewed-by's or acked-by's to be seen. 
> Is that a fair commentary on what has been happening, or have people
> been remiss in sending and gathering such things?

I still have concerns about the consequences of merging this as anything
other than a debug option [1]. Unfortunately, merging it as a debug option
defeats the whole point, so I think we need to spend more effort on developing
tools that can help us to find and fix the subtle bugs which will arise from
enabling tagged pointers in the kernel.

Will

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/596077.html
