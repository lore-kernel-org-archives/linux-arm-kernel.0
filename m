From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Fri, 20 Jul 2018 17:36:00 +0300
Subject: [PATCH v6 3/8] interconnect: Add debugfs support
In-Reply-To: <20180715121507.GA17794@kroah.com>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
 <20180709155104.25528-4-georgi.djakov@linaro.org>
 <20180715121507.GA17794@kroah.com>
Message-ID: <3a0d35bb-f55a-28c0-f2a6-0f2b49422896@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 15.07.18 ?. 15:15, Greg KH wrote:
> On Mon, Jul 09, 2018 at 06:50:59PM +0300, Georgi Djakov wrote:
>> +static int __init icc_debugfs_init(void)
>> +{
>> +	struct dentry *file;
>> +
>> +	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
>> +	if (!icc_debugfs_dir) {
>> +		pr_err("interconnect: error creating debugfs directory\n");
>> +		return -ENODEV;
>> +	}
> 
> You should never care about the return value of a debugfs call.  Just
> ignore it and move on.

Ok!

>> +	file = debugfs_create_file("interconnect_summary", 0444,
>> +				   icc_debugfs_dir, NULL, &icc_summary_fops);
>> +	if (!file)
>> +		return -ENODEV;
> 
> Again, do not check this.
> 
> Where do you remove this directory and file from the system when the
> code shuts down?

Will take care of this! Thanks for the feedback!

Georgi
