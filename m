From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 27 Nov 2017 20:59:19 +0300
Subject: [PATCH] arm64: fix missing 'const' qualifiers
In-Reply-To: <CAKwvOdm+65Fx1gLZR3h7Vz-Ma4DNWR4W=cOL8KpKZXMgN-nCLg@mail.gmail.com>
References: <20171125094127.7536-1-ynorov@caviumnetworks.com>
 <CAKwvOdm+65Fx1gLZR3h7Vz-Ma4DNWR4W=cOL8KpKZXMgN-nCLg@mail.gmail.com>
Message-ID: <20171127175919.y5hr7qgvhkdwanbm@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 09:15:50AM -0800, Nick Desaulniers wrote:
> Checked call sites, looks like no one tries to modify these pointers.
> I too prefer to make things as const as possible, though I recently
> had a coworker refer to the propagation of const in a code base as a
> "Gordian knot," which I thought was eloquent.
>
> checkpatch mentions that there's one line that's over 80 chars, and
> that there's M$ DOS style line endings (but that may just be my client
> gmail, or yours (exchange?)).  If you fix up that long line, then:

I happily use mutt, but my company's mail server is MS Outlook, so I 
have to send everything with msmtp. It usually works. In fact, this
is the first complain for 2 years. 

My checkpatch:
yury:linux$ scripts/checkpatch.pl const.patch 
total: 0 errors, 0 warnings, 32 lines checked

const.patch has no obvious style problems and is ready for submission.

I guess, because 1 line is exactly 80 chars length, and because MS format
adds another symbol as line delimiter, we end up with 81 chars in line,
which makes checkpatch worrying.

CC Joe Perches and Andy Whitcroft for it.

> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks
