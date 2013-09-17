From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 17 Sep 2013 20:48:31 +0200
Subject: [PATCH] arm: Kirkwood - Remove kirkwood_setup_wins and rely on
 the DT binding
In-Reply-To: <20130917181742.GA4182@obsidianresearch.com>
References: <20130916224743.GA18349@obsidianresearch.com>
 <20130917133206.GB2488@localhost>
 <20130917153619.GA14098@obsidianresearch.com> <20130917200301.66e8ccb9@skate>
 <20130917181742.GA4182@obsidianresearch.com>
Message-ID: <5238A3FF.4030305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2013 08:17 PM, Jason Gunthorpe wrote:
> On Tue, Sep 17, 2013 at 08:03:01PM +0200, Thomas Petazzoni wrote:
>> but until that exists, we thought that pushing the ranges property down
>> to the .dts file was the least horrible solution.
>
> I think we can get away with doing it the other way for kirkwood,
> here are my reasons:
>   - Kirkwood is mature now, the DT is basically complete, we shouldn't
>     need to churn the ranges in the dtsi much, if at all.
>   - There are 31 kirkwood dts files, and none of them need a ranges
>     different from the default
>   - Kirkwood has more than enough mbus windows, we don't need to be
>     stingy with them
>   - The board files were already sort of like this, but a big chunk
>     of the 31 boards were missing ranges entirely.
>
> Basically, no board file has a ranges, only the kirkwood.dtsi has a
> ranges.

Dove will also have its mbus ranges located in the SoC dtsi for the
same above reasons. The patch is already queued in mvebu/for-next.

Sebastian
