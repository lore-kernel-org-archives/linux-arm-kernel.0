From: eric@anholt.net (Eric Anholt)
Date: Fri, 02 Oct 2015 12:53:03 -0700
Subject: [PATCH v3 3/4] clk: bcm2835: Add support for programming the
 audio domain clocks.
In-Reply-To: <20151002000741.GA1213@codeaurora.org>
References: <1443475325-22270-1-git-send-email-eric@anholt.net>
 <1443475325-22270-3-git-send-email-eric@anholt.net>
 <20151002000741.GA1213@codeaurora.org>
Message-ID: <87lhblt5cw.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 09/28, Eric Anholt wrote:
>> +
>> +static const char *bcm2835_clock_per_parents[] = {
>> +static const char *bcm2835_clock_vpu_parents[] = {
>> +static const char *bcm2835_clock_osc_parents[] = {
>
> Can these parent arrays be const char * const ?

They couldn't because I was editing them in place to do the
s/"xosc"/of_clk_get_parent_name()/ edit.  I've moved the edit to being
in a stack allocation at probe time.

I think I've done all of your suggested changes in the new version (and
explained the extra ana2 read/write).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/41bf9f7e/attachment.sig>
