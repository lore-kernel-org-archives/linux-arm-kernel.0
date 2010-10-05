From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 5 Oct 2010 09:29:09 +0900
Subject: [alsa-devel] [PATCH 3/10] ARM: S5PC100: Add SCLK_SPDIF clock
In-Reply-To: <20101004183041.GD2835@opensource.wolfsonmicro.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286192545-18327-1-git-send-email-sw.youn@samsung.com>
	<20101004183041.GD2835@opensource.wolfsonmicro.com>
Message-ID: <AANLkTimZLQLRP33e_1ZbHOLYOToHXjhyjY09F9gb7q+b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 5, 2010 at 3:30 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Oct 04, 2010 at 08:42:25PM +0900, Seungwhan Youn wrote:
>> This patch add SCLK_SPDIF clock to support source clock of S/PDIF
>> on S5PC100.
>>
>> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> but...
>
>> +static int s5pc100_spdif_set_rate(struct clk *clk, unsigned long rate)
>> +{
>> + ? ? struct clk *pclk;
>> + ? ? int ret;
>
> This and the get() look like they're generic (they just proxy the
> operation on to the parent clock, which I imagine applies to a bunch of
> other clocks too.

Yes, that should apply to all Mux-Out and PAD 'clocks'.
I plan to submit a patch to have that feature in Samsung clock API --
call parent's operators
if the clock doesn't have one.
Since that might be a controversial change and hence delays in
acceptance (if at all),
we decided to do that for the devices that need it for now.
