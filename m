From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 20 Jun 2018 10:13:11 -0400
Subject: Dynamic ftrace self test broken on ARM
In-Reply-To: <5e26cebbb2ebeb87fdc808509881736b@agner.ch>
References: <65fb14b356bc0a414f1fe5cf5c6eb395@agner.ch>
 <20180618175437.3e6c85a1@gandalf.local.home>
 <b9f269ed2143688c38cdcbba7367b101@agner.ch>
 <20180619091735.7aec75d0@gandalf.local.home>
 <5e26cebbb2ebeb87fdc808509881736b@agner.ch>
Message-ID: <20180620101311.0bcd73d3@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Jun 2018 15:51:55 +0200
Stefan Agner <stefan@agner.ch> wrote:


> v4.9 seems to work, so I started bisecting. It turned out that commit
> 6f05d0761af6 ("ARM: 8668/1: ftrace: Fix dynamic ftrace with DEBUG_RODATA
> and !FRAME_POINTER") broke it, introduced during the v4.12 merge window.

That patch doesn't appear to be the cause. It could have been a failed
bisect. Does the commit before that commit work? Does that commit fail?

It may be due to some other RODATA change though. That is actually one
of my thoughts when looking at the bug.

-- Steve
