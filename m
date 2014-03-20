From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 20 Mar 2014 05:41:00 -0700
Subject: [PATCH 1/5] mtd: st_spi_fsm: Remove useless consts from function
 arguments
In-Reply-To: <1395317630.7776.29.camel@joe-AO722>
References: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
 <1395313907-25318-2-git-send-email-lee.jones@linaro.org>
 <1395314713.7776.17.camel@joe-AO722>
 <20140320114123.GE21349@lee--X1>
 <1395316090.7776.24.camel@joe-AO722>
 <20140320115412.GU31517@norris-Latitude-E6410>
 <20140320120307.GA9240@lee--X1>
 <1395317630.7776.29.camel@joe-AO722>
Message-ID: <CAN8TOE9g2VwVgVx1Sj3OcguuwP_A9pJS+WpgTAL49KyN9r1CiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 5:13 AM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2014-03-20 at 12:03 +0000, Lee Jones wrote:
>> > Good catch. That wasn't my intention.
>> > > Why?
>> An oversight.
>
> That's still not an explanation.
>
> Why, unless cast away by the code itself, is
> const removal a good thing?

It's not so much removal as it is review of the initial driver merge.
I'd contend that const was applied somewhat thoughtlessly originally,
and it didn't really serve a good purpose.

> It does serve as an indication to a reader what
> the code does with the argument.
>
> About the only reason I can think of arguing in
> favor of removal is inconsistent application of
> const within the module.

That's one good reason. And not only consistency within the modules,
but consistency within the subsystem (and the kernel at large,
really). There's rarely a case of a const function parameter. And I'm
sure there are numerous function parameters which could potentially be
marked 'const'.

I also don't think that a function parameter is the right place to
mark const like this. Function arguments are always pass-by-value, so
this 'const' tells users (callers) nothing useful. It only provides
useless constraints on what the function can do with its copy of the
parameter.

Brian
