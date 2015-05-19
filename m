From: robherring2@gmail.com (Rob Herring)
Date: Mon, 18 May 2015 19:37:59 -0500
Subject: How to encode being an I2C slave in DT?
In-Reply-To: <20150506161712.GA4003@katana>
References: <1427745615-5428-1-git-send-email-danindrey@mail.ru>
 <20150403194635.GC2016@katana> <1549160.njMIY2NVTi@fb07-iapwap2>
 <20150505105513.GA1841@katana> <554922EF.3050906@wwwdotorg.org>
 <20150506161712.GA4003@katana>
Message-ID: <CAL_Jsq+iyeK-bV3ggcJv8Cw3EU71fkBo1wqYZnhCoh2-b_tO-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 6, 2015 at 11:17 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> The container node has a #address-cells property for this very reason. It's
>> perfectly well-defined how to split up a property containing a large number
>> of cells into separate values, by using the value of #address-cells. Plus,
>> the canonical formatting (albeit not enforced by the DT compiler) for a
>> property that contains an array of entries, each 2 cells in size, would be:
>>
>> reg = <0 0x1a>, <0 0x40>, <0 0x48>;
>>
>> rather than:
>>
>> reg = <0 0x1a 0 0x40 0 0x48>;
>>
>> ... so it's quite simple to make it very human-readable too.
>
> I give in to the flag idea. I also noticed that we'd need another flag
> anyhow to mark 10 bit addresses. I am still thinking between using two
> address-cells in that case (clean seperation between address and flags)
> or to encode the flags as MSB in the current address (all busses will
> have same address-cells and child description, less code paths and no
> overhead in dtbs).

Reading thru the thread, this seems good to me. I would go with adding
flags in the MSB of the reg cell rather than adding a cell.

Rob
