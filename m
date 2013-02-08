From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Fri, 8 Feb 2013 17:31:50 +0100
Subject: Porting 3.8-rc4-nohz3 to ARM (PandaBoard)
In-Reply-To: <20130204200238.GA16718@enea.se>
References: <20130204200238.GA16718@enea.se>
Message-ID: <CAFTL4hyNZdjmSij0DDouu0mmD5E3xApq7i=dZD941ZtCM1QyjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/2/4 Mats Liljegren <mats.liljegren@enea.com>:
> Hi Frederic,
>
> (Sorry for the re-post, I spelled the mailing list wrong...)
>
> I want to port dynticks patches 3.8-rc4-nohz3 to ARM architecture, and try it out on the PandaBoard. Initially this is for evaluating it, but if it looks promising I'd like to upstream this.
>
> As far as I can see the first thing to do is to implement virtual time accounting. After an initial look at the patches done for ia64, it doesn't look too difficult.

No that part is handled by the core code. But you need to implement
the context tracking arch backend.
Here is what Li Zhong did to port it on Powerpc for example:
https://lkml.org/lkml/2013/2/1/216

> Are there any caveats I should be aware of?

The generic cputime accounting only works on 64 bits archs. We'll need
to do some safe accessors to read the kernel_stat. In the meantime you
can do home tests by removing the CONFIG_64BIT dependency. This
shouldn't be dangerous

> Has anyone else started any work in this area that I could co-operate with?

Yeah two people have been working on this. But it was several month
ago and I haven't hear from them since then. I'm adding Geoff in Cc. I
can't retrieve the other guy who has worked on it too.
