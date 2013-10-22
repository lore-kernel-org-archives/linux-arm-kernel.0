From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Tue, 22 Oct 2013 10:54:14 -0700
Subject: [PATCH v3 1/2] init/do_mounts.c: ignore final \n in name_to_dev_t
In-Reply-To: <20131010175010.17870.58060@capellas-linux>
References: <1380834638-24035-1-git-send-email-sebastian.capella@linaro.org>
 <1380834638-24035-2-git-send-email-sebastian.capella@linaro.org>
 <20131003141523.8b60ab988799af7e2b2c338b@linux-foundation.org>
 <20131003214246.24540.99218@capellas-linux>
 <20131003234735.19051.84583@capellas-linux>
 <20131010175010.17870.58060@capellas-linux>
Message-ID: <20131022175414.14753.58063@capellas-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sebastian Capella (2013-10-10 10:50:10)
> Quoting Sebastian Capella (2013-10-03 16:47:35)
> > Quoting Sebastian Capella (2013-10-03 14:42:46)
> > I looked into removing the const from the store function, but I'm not sure
> > this is the right idea, so I'm going to shelf that for now.
> > 
> Below are the three options considered thus far.  Do
> you have any additional suggestions or preferences?
> 
> 1) copy buffer, remove \n.
>   - v1 patch did this
>   - alternatively could use an array on the stack or a preallocated global
>     Pros:
>      . cleanest change
>      . could use strim() proposed by Andrew
>     Cons:
>      . adds memcpy
> 2) make name_to_dev_t work with readonly buffer to ignore \n
>   - v2 and v3 patches do this
>     Pros:
>      . no memcpy, no big modifications to unrelated code
>     Cons:
>      . seems more appropriate to harden store functions to user input
>        than name_to_dev_t.
>      . a little complicated
> 3) remove const from buffer and modify contents in place to remove \n
>   - remove const from sysfs_ops.store, modify dependent definitions
>   - remove const from kobj_attribute.store, modify dependent definitions
>     Pros:
>      . no memcpy
>     Cons:
>      . a lot of modifications
>      . const contract to not modify the input buffer seems the right way.

Hi Andrew,

Do you have any feedback for me on this?

I'm happy do make any changes you think are correct, but I'm unsure if
you're asking me for option #3 above.  It's quite an intrusive change,
and changes old, established code and I'd like confirmation that's what
you'd like before proceeding down that path.

I've submitted patches with both options #1 and #2 above.

Thanks,

Sebastian
