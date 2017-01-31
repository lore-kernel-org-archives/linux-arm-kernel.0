From: john.garry@huawei.com (John Garry)
Date: Tue, 31 Jan 2017 13:34:24 +0000
Subject: [PATCH V6 1/5] LIB: Indirect ISA/LPC port IO introduced
In-Reply-To: <20170131000914.GA11331@bhelgaas-glaptop.roam.corp.google.com>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-2-git-send-email-yuanzhichang@hisilicon.com>
 <20170131000914.GA11331@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <fec21b66-4ba7-3855-af53-a0e2856754a4@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/01/2017 00:09, Bjorn Helgaas wrote:
> On Tue, Jan 24, 2017 at 03:05:21PM +0800, zhichang.yuan wrote:
>> Low-pin-count interface is integrated into some SoCs. The accesses to those
>> peripherals under LPC make use of I/O ports rather than the memory mapped I/O.
>>
>> To drive these devices, this patch introduces a method named indirect-IO.
>
> It's slightly confusing to call this "indirect I/O" and then use
> "extio" for the filename and function prefix.  It'd be nice to use
> related names.

We will consider something more consistent.

>
>> +struct extio_node {
>> +	unsigned long bus_start;	/* bus start address */
>> +	unsigned long io_start;	/* io port token corresponding to bus_start */
>> +	size_t range_size;	/* size of the extio node operating range */
>> +	struct fwnode_handle *fwnode;
>> +	struct list_head list;
>> +	struct extio_ops *ops;	/* ops operating on this node */
>> +	void *devpara;	/* private parameter of the host device */
>> +};
>
> I wish we didn't have both struct io_range and struct extio_node.  It
> seems like they're both sort of trying to do the same thing.  Maybe
> this is the same as what Alex is saying.
>

I think so. I have just replied to Alex regarding this.

> Bjorn
>

Thanks,
John

> .
>
