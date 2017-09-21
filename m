From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 21 Sep 2017 12:19:45 +0100
Subject: [PATCH v2 14/28] arm64/sve: Backend logic for setting the vector
 length
In-Reply-To: <E82895B2-3F95-4A54-8703-D654221F8CBA@arm.com>
References: <1504198860-12951-1-git-send-email-Dave.Martin@arm.com>
 <1504198860-12951-15-git-send-email-Dave.Martin@arm.com>
 <FC5BA359-D37C-493C-87CD-146B83D3CCB5@arm.com>
 <20170920110902.GG24231@e103592.cambridge.arm.com>
 <E82895B2-3F95-4A54-8703-D654221F8CBA@arm.com>
Message-ID: <20170921111937.GA17434@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 06:08:21PM +0000, Alan Hayward wrote:
> 
> > On 20 Sep 2017, at 12:09, Dave Martin <dave.martin@foss.arm.com> wrote:

[...]

> >> Given, sve_set_vector_length is called when setting the vector length in
> >> PTRACE_SETREGSET, it looks to me like if you set VL to a value that?s not
> >> supported by the hardware, then it?s going to round down to the previous value.
> >> Is that correct? I?m not sure if that?s explained in the docs?
> > 
> > Does this cover it?
> > 
> > "On success, the calling thread's vector length is changed to the
> > largest value supported by the system that is less than or equal to vl."
> > 
> > (For ptrace, I just cross-reference the PR_SVE_SET_VL behaviour, above.)
> 
> For ptrace is it worth mentioning user should do a GET after a SET to confirm
> what VL value was actually set?

This seems worth a clarification -- I'd thought this was already
mentioned, but it isn't.

How about:

  The caller must make a further GETREGSET call if it needs to know what VL is
  actually set by SETREGSET, unless is it known in advance that the requested
  VL is supported.


[...]

Cheers
---Dave
