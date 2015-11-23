From: keescook@chromium.org (Kees Cook)
Date: Mon, 23 Nov 2015 10:56:11 -0800
Subject: [PATCH 1/2] arch: consolidate CONFIG_STRICT_DEVM in
 lib/Kconfig.debug
In-Reply-To: <CAPcyv4hDbi5KJ+tGJnEwQV5G=PM+ZRooQbgTNrYxyyVVPA3EwA@mail.gmail.com>
References: <20151122035702.9313.52457.stgit@dwillia2-desk3.jf.intel.com>
 <20151123081235.GA23661@gmail.com>
 <CAPcyv4hDbi5KJ+tGJnEwQV5G=PM+ZRooQbgTNrYxyyVVPA3EwA@mail.gmail.com>
Message-ID: <CAGXu5jLpm7iG17+ws2MfK7ZG9KEDaHWd5xxHSk7KHPyizYEm2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 9:12 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Mon, Nov 23, 2015 at 12:12 AM, Ingo Molnar <mingo@kernel.org> wrote:
>>
>> * Dan Williams <dan.j.williams@intel.com> wrote:
>>
>>> Let all the archs that implement CONFIG_STRICT_DEVM use a common
>>> definition in lib/Kconfig.debug.
>>
>> For the x86 bit:
>>
>> Acked-by: Ingo Molnar <mingo@kernel.org>
>>
>>> Note, the 'depends on !SPARC' is due to sparc not implementing
>>> devmem_is_allowed().
>>
>> Maybe that should be converted into a helper Kconfig switch for architectures to
>> opt in to /dev/mem restrictions?
>
> Sure, easy enough to add a ARCH_HAS_DEVMEM_IS_ALLOWED opt-in.

Is there some hidden meaning about the difference between ARCH_HAS_...
and HAVE_ARCH_... and HAVE_... ?

-Kees

-- 
Kees Cook
Chrome OS Security
