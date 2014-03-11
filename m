From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Mar 2014 15:35:03 -0700
Subject: [PATCH] ARM: zynq: Add OCM driver
In-Reply-To: <e870cbc7-5934-4a14-aab4-416cdfd1627d@VA3EHSMHS007.ehs.local>
References: <299e37ab245da9132808c6d4265a17b9a417bf62.1389022555.git.michal.simek@xilinx.com>
 <CAOesGMiroyjPbcjfG24_sUqCicCD4M7NF2aD=Xi8NVgagZThuA@mail.gmail.com>
 <e870cbc7-5934-4a14-aab4-416cdfd1627d@VA3EHSMHS007.ehs.local>
Message-ID: <CAOesGMiHf9efd8_RGg=0XCR9Qvy8=YUAMLPX-O4yOC8g-e8d9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 3:13 PM, S?ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> On Tue, 2014-03-11 at 02:31PM -0700, Olof Johansson wrote:
>> Hi Michal,
>>
>> Sorry for the late review, I didn't notice the driver when it was
>> posted and I only saw it now with the pull request. Comments below.
>>
>>
>> On Mon, Jan 6, 2014 at 7:36 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> > The driver provide memory allocator which can
>> > be used by others drivers to allocate memory inside OCM.
>> > All location for 64kB blocks are supported
>> > and driver is trying to allocate the largest continuous
>> > block of memory.
>>
>> I don't think you explain what OCM is anywhere, what is it? Since
>> you're reusing the generic SRAM driver I'm suspecting it's related?
>
> It stands for 'On-Chip Memory'. For Zynq that is a RAM consisting of
> four 64k chunks that can be individually mapped to a high or low address.

Ok, yeah, then it definitely should share drivers as much as possible
with the other vendors.


-Olof
