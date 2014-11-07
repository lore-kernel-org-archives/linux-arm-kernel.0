From: keescook@chromium.org (Kees Cook)
Date: Fri, 7 Nov 2014 08:44:18 -0800
Subject: [RFC] ptrace: add generic SET_SYSCALL request
In-Reply-To: <6654405.Rf26mgoaDJ@wuerfel>
References: <1415346443-28915-1-git-send-email-takahiro.akashi@linaro.org>
 <353850534.aGkkrtTogX@wuerfel> <20141107131129.GF18916@arm.com>
 <6654405.Rf26mgoaDJ@wuerfel>
Message-ID: <CAGXu5jLBWiVieCkMFTboi5tEYw40O=-3_nH4jnMgKGQCrE6f1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 7, 2014 at 6:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 07 November 2014 13:11:30 Will Deacon wrote:
>>
>> > It's not that I care strongly about the interface, my main point is
>> > that the changelog doesn't describe why one interface was used instead
>> > the other.
>>
>> I suspect the current approach was taken because it follows the same scheme
>> as 32-bit ARM. If both methods are sufficient (Kees would have a better idea
>> than me on that), then I don't have a strong preference.
>
> Using the regset would probably address Oleg's comment, and would keep the
> implementation architecture specific. You could even share the NT_S390_SYSTEM_CALL
> number, but I don't know if there any downsides to doing that.

That's fine by me -- I only want an interface. :) I think it'd be nice
to keep it the same between arm32 and arm64, but using a specific
regset does seem to be the better approach.

-Kees

-- 
Kees Cook
Chrome OS Security
