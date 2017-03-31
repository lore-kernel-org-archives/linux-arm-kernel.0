From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 31 Mar 2017 09:01:31 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.12
In-Reply-To: <CAK8P3a02e3DxjuW9pA66NSCc9vw_h1Xuk6TdEbRnEQ4v4W7NHA@mail.gmail.com>
 (Arnd Bergmann's message of "Fri, 31 Mar 2017 16:02:41 +0200")
References: <m28tnn69ls.fsf@baylibre.com>
 <CAK8P3a02e3DxjuW9pA66NSCc9vw_h1Xuk6TdEbRnEQ4v4W7NHA@mail.gmail.com>
Message-ID: <m2fuht4eqs.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wed, Mar 29, 2017 at 11:45 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Olof, Arnd,
>>
>> Below are some 64-bit DT changes for Amlogic platforms for v4.12.  Note
>> that this branch includes a merge of an immutable branch from the clk
>> tree (clk-meson) due to dependencies on new clocks added to the meson
>> clock driver and used in these DT updates.
>
> I did not pull this one because of the silly dependency. The device tree
> files should be completely independent of the driver changes.

Aaargh, this is getting very frustrating.

[...]

> Which add random macros in the middle of the number space.
>
> Since the header changes are in an immutable branch, it's probably
> too late to fix this for 4.12, but maybe we can get the header into a
> form that allows us to do future DT changes without having to
> wait an extra release. The clock driver apparently already defines
> some of the numbers above, so you can fill all of those in already.

We could, but this is in direct conflict with the recommendations of the
clk maintainers to not expose clock IDs to the DT until we know they are
used because, well, things change.

Can we *please* get some clarity on on this between arm-soc and the clk
maintainers?  I've been asking for a couple merge windows now.

Irritated,

Kevin
