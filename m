From: robh@kernel.org (Rob Herring)
Date: Wed, 19 Jul 2017 10:28:51 -0500
Subject: [PATCH] clocksource: Convert to using %pOF instead of full_name
In-Reply-To: <b6f4661d-6655-0fb9-f212-2d777a12e11a@sigmadesigns.com>
References: <20170718214339.7774-13-robh@kernel.org>
 <b6f4661d-6655-0fb9-f212-2d777a12e11a@sigmadesigns.com>
Message-ID: <CAL_Jsq+qMn2HHeNx2PmYSJ-pYMRFPYXVHivBgX5vpjKngJHShg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 19, 2017 at 3:55 AM, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:
> On 18/07/2017 23:42, Rob Herring wrote:
>
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>
> Nice. For my own reference:
> http://elixir.free-electrons.com/linux/v4.13-rc1/source/Documentation/printk-formats.txt#L349
>
> About removing the full path. Does this mean that ultimately
> %pOF will print just the name? And the 'f' spec will disappear?

No, the vsprintf code is already designed to print the full path
whether full_name is the full path or just the basename. %pOF is just
the default. "f" is needed so you can combine it with the other
specifiers.

> Is this done to save memory?

Yes. That's the next step.

Rob
