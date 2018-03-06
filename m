From: james.morse@arm.com (James Morse)
Date: Tue, 06 Mar 2018 17:59:06 +0000
Subject: [RFC PATCH] arm64: fault: Don't populate ESR context for user
 fault on kernel VA
In-Reply-To: <20180306160553.GN32331@e103592.cambridge.arm.com>
References: <1520245875-32527-1-git-send-email-will.deacon@arm.com>
 <20180305140506.GJ32331@e103592.cambridge.arm.com>
 <20180305172418.GD12869@arm.com>
 <CAFEAcA9e1swOcYx5YCokSmb_37pyaJYJZTudt57babkngicutw@mail.gmail.com>
 <20180306160553.GN32331@e103592.cambridge.arm.com>
Message-ID: <5A9ED6EA.3040700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave, Peter,

On 06/03/18 16:05, Dave Martin wrote:
> On Tue, Mar 06, 2018 at 03:59:59PM +0000, Peter Maydell wrote:
>> AFAIK the major thing that consumers actually are after here
>> is the WnR information, so preserving that and sanitizing
>> the rest of the ESR if necessary would be a less risky fix IMHO.
> 
> If there is a way of squashing the syndrome information so that it
> reports a fixed syndrome except for information about what userspace
> attempted to do (i.e., WnR -- I dunno if there's anything else), that
> seems reasonable.

Anything else? For the RAS stuff I planned to use this to indicate whether a
SIBGUS due to hwpoison was due to an instruction or data abort, so a
sanitised-EC field would be good.

(this lets KVMs user-space inject the correct flavour of external-abort)


Thanks,

James
