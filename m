From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 20 Mar 2014 09:58:07 -0700
Subject: [PATCH 1/5] mtd: st_spi_fsm: Remove useless consts from function
 arguments
In-Reply-To: <1395319485.7776.32.camel@joe-AO722>
References: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
 <1395313907-25318-2-git-send-email-lee.jones@linaro.org>
 <1395314713.7776.17.camel@joe-AO722>
 <20140320114123.GE21349@lee--X1>
 <1395316090.7776.24.camel@joe-AO722>
 <20140320115412.GU31517@norris-Latitude-E6410>
 <20140320120307.GA9240@lee--X1>
 <1395317630.7776.29.camel@joe-AO722>
 <CAN8TOE9g2VwVgVx1Sj3OcguuwP_A9pJS+WpgTAL49KyN9r1CiA@mail.gmail.com>
 <1395319485.7776.32.camel@joe-AO722>
Message-ID: <20140320165807.GV31517@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 05:44:45AM -0700, Joe Perches wrote:
> On Thu, 2014-03-20 at 05:41 -0700, Brian Norris wrote:
> > I also don't think that a function parameter is the right place to
> > mark const like this. Function arguments are always pass-by-value, so
> > this 'const' tells users (callers) nothing useful. It only provides
> > useless constraints on what the function can do with its copy of the
> > parameter.
> 
> Again, that's not useless information.

For local, pass-by-value function arguments (i.e., constant data, or
constant pointers to data), I respectfully disagree. (For "pointers to
constant data", I completely agree that the 'const' info is useful.)

> And as you've seen, just making these changes
> can be error prone.

Thank you for catching our mistake now. But I don't think that is
relevant; just because you caught an error doesn't mean that the change
(primarily for consistency's sake) should be avoided entirely.

Unless you have a more convincing argument, this code will remain as-is.

Regards,
Brian
