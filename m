From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 15 Dec 2017 13:41:30 +0100
Subject: [PATCH] arm: dts: Remove leading 0x and 0s from bindings notation
In-Reply-To: <CA+7wUsxMdukt2hu+HKua-C5OwSY-yexVgGnkq071yC5A6XX-_A@mail.gmail.com>
References: <20171214165350.27850-1-malat@debian.org>
 <CAJKOXPeLiPfoUfpPU-sAAOuD057kTzRE-g4bFq4afFOOtRRZOg@mail.gmail.com>
 <CA+7wUsz9FO5ytY3a6RONu+kGm1NKjK8z378UzxjUWmk2tBhi7A@mail.gmail.com>
 <CA+7wUsxMdukt2hu+HKua-C5OwSY-yexVgGnkq071yC5A6XX-_A@mail.gmail.com>
Message-ID: <CAJKOXPecm-e7P6uFvdDCBimcFbvATpf5pfJyzLXgKdTwFDPEJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 1:18 PM, Mathieu Malaterre <malat@debian.org> wrote:
>> As discussed with Krzysztof, I've split the ARM patch into subarch.
>> Please drop this one.
>
> Hum...looks like my internet provider just blacklisted me for too many
> recipient in the mail. I'll do my best to resolve this, and send the
> rest of the  series.

You can fix this by:
1. sending each mail separately (some for-do loop in bash with 'git
send-email --cc-cmd "scripts/get_maintainer.pl --no-git --no-roles
--no-rolestats --no-git-fallback"') because these are really
independent patches,
2. create a cover letter sent to everyone but send particular commits
only to respective folks:
a. get list of cc for cover letter:
scripts/get_maintainer.pl --no-multiline --interactive --separator=\''
--to '\' --no-git --no-roles --no-rolestats --no-git-fallback 00*
b. send patches (except cover letter now):
git send-email --cc-cmd "scripts/get_maintainer.pl --no-git --no-roles
--no-rolestats --no-git-fallback" --to linux-kernel at vger.kernel.org
--no-thread --in-reply-to='<COVER_LETER_THREAD_ID>' 000[1-9]-*
00[1-9]*-*

Best regards,
Krzysztof
