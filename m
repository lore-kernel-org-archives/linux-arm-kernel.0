From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 06 Feb 2015 14:09:12 +0000
Subject: Kexec and KVM not working gracefully together
In-Reply-To: <CAHt6W4f-maGM75toP1TJV8wCZpZC3+ER9KqAnASJPhK8f_+aqg@mail.gmail.com>
References: <CAHt6W4cuRi3bfj5mryFouhOLGAAWuNXKVvz4K-rAjQnwiegL-Q@mail.gmail.com>
 <54C7ADF0.8090102@arm.com> <54D30AE0.5050101@linaro.org>
 <20150205094317.43f8554a@arm.com> <54D34592.9010903@linaro.org>
 <CAHt6W4dS-fv0U+=ch1-=X36EpyE5FA89aY8LVqbFP0+R3GvLqw@mail.gmail.com>
 <54D37108.9020103@arm.com>
 <CAHt6W4cckuuK+=1ZHNUEEW5BuiyiGNc2CeuP9O7MaC0WpScZoA@mail.gmail.com>
 <CAHt6W4eQ3iC+sqWAn5LkkfC-XBgGWR0i6TXjWvzEsUqFh75fwQ@mail.gmail.com>
 <54D43F52.7030606@linaro.org>
 <CAHt6W4eQ1q+JxmB2o4MigDF+Li98iYhBfg2KXTTq3wGcNSCKMw@mail.gmail.com>
 <54D49DD5.3010202@linaro.org>
 <CAHt6W4f-maGM75toP1TJV8wCZpZC3+ER9KqAnASJPhK8f_+aqg@mail.gmail.com>
Message-ID: <54D4CB08.8090306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/15 12:14, Frediano Ziglio wrote:

> I was going to add an kvm_call_hyp_ext function which in either arm32
> or arm64 could pass up to 8 register parameters. Does it make sense?

Not unless you can prove that you don't have any other way of doing what
you want to achieve.

We perfectly deal with having only 4 registers on the init sequence, and
I doubt that you cannot do it the same way, possibly using a
per-architecture abstraction (see __cpu_init_hyp_mode).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
