From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 28 Apr 2017 08:33:23 +0200
Subject: [PATCH v8 1/4] syscalls: Verify address limit before returning
 to user-mode
In-Reply-To: <CAJcbSZENjCgn3TNDGzCBBSOXMvbTX8mBO7Trugdb5VRzhxwmHg@mail.gmail.com>
References: <20170426183425.32158-1-thgarnie@google.com>
 <20170427064917.phwo6yl4v4q43fql@gmail.com>
 <CAJcbSZENjCgn3TNDGzCBBSOXMvbTX8mBO7Trugdb5VRzhxwmHg@mail.gmail.com>
Message-ID: <20170428063323.ntnc4tk7do2dor76@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Thomas Garnier <thgarnie@google.com> wrote:

> > BTW., a further simplification would be:
> >
> > #ifndef ADDR_LIMIT_CHECK_PRE
> > # define ADDR_LIMIT_CHECK_PRE ...
> > #endif
> >
> > This way architectures could override this generic functionality simply by
> > defining the helpers. Architectures that don't do that get the generic version.
> 
> I don't think architectures need to do that. The optimizations are
> embedding the checks on their architecture-specific code to make it
> faster and remove the size impact. The pre/post is fine for the rest.

Indeed, only the generic code needs to turn off that code - architectures will 
place these callbacks elsewhere.

Thanks,

	Ingo
