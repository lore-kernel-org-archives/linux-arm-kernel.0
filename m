From: delicious.quinoa@gmail.com (Alan Tull)
Date: Wed, 28 Sep 2016 23:34:51 -0500
Subject: [PATCH v19 05/12] fpga-mgr: add fpga image information struct
In-Reply-To: <CAAtXAHcdSsVUE4hQ6isCp7_35ZKb60EAKAgtGwBR41apwPpe=g@mail.gmail.com>
References: <20160928182200.15800-1-atull@opensource.altera.com>
 <20160928182200.15800-6-atull@opensource.altera.com>
 <CAAtXAHcdSsVUE4hQ6isCp7_35ZKb60EAKAgtGwBR41apwPpe=g@mail.gmail.com>
Message-ID: <CANk1AXTbKhiSu3XN4HgTM_rBBQ315qseH06RzojOOZrV74M7yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2016 at 6:41 PM, Moritz Fischer
<moritz.fischer@ettus.com> wrote:
Hi Moritz,

> Hi Alan,
>
> generally ok with the change.

Cool!

>
> On Wed, Sep 28, 2016 at 11:21 AM, Alan Tull <atull@opensource.altera.com> wrote:
>
>> -int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags, const char *buf,
>> -                     size_t count)
>> +int fpga_mgr_buf_load(struct fpga_manager *mgr, struct fpga_image_info *info,
>> +                     const char *buf, size_t count)
>
> Doesn't this break the both socfpga and zynq if [6/12] and [7/12] are
> not part of this commit?
> i.e shouldn't 5,6 and 7 be a single commit?

Yeah, squashing those would improve bisectability.

Alan
aka atull

>
> Cheers,
> Moritz
