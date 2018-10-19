From: gorcunov@gmail.com (Cyrill Gorcunov)
Date: Fri, 19 Oct 2018 19:49:27 +0300
Subject: [PATCH v5 07/17] arm64: add basic pointer authentication support
In-Reply-To: <20181019112404.GD14246@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-8-kristina.martsenko@arm.com>
 <20181019111542.6wrvjguirglzg7vg@mbp>
 <20181019112404.GD14246@arm.com>
Message-ID: <20181019164927.GO2401@uranus.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 12:24:04PM +0100, Will Deacon wrote:
> 
> FWIW: I think we should be entertaining a prctl() interface to use a new
> key on a per-thread basis. Obviously, this would need to be used with care
> (e.g. you'd fork(); use the prctl() and then you'd better not return from
> the calling function!).
> 
> Assuming we want this (Kees -- I was under the impression that everything in
> Android would end up with the same key otherwise?), then the question is
> do we want:
> 
>   - prctl() get/set operations for the key, or
>   - prctl() set_random_key operation, or
>   - both of the above?
> 
> Part of the answer to that may lie in the requirements of CRIU, where I
> strongly suspect they need explicit get/set operations, although these
> could be gated on CONFIG_CHECKPOINT_RESTORE=y.

Indeed. Without get/set I think we won't be able to restore programs.
