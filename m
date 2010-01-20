From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Jan 2010 09:57:57 +0000
Subject: [PATCH/RFC v1 0/2] Human readable performance event
	description in sysfs
In-Reply-To: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
Message-ID: <20100120095757.GA20302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 10:11:44AM +0100, Tomasz Fujak wrote:
> The following patches provide a sysfs entry with hardware event human
> readable description in the form of "0x%llx\t%lld-%lld\t%s\t%s" %
> (event_value, minval, maxval, name, description)

I think your patch is in violation of this from
Documentation/filesystems/sysfs.txt:

Attributes
~~~~~~~~~
...
Attributes should be ASCII text files, preferably with only one value
per file. It is noted that it may not be efficient to contain only one
value per file, so it is socially acceptable to express an array of
values of the same type.

Mixing types, expressing multiple lines of data, and doing fancy
formatting of data is heavily frowned upon. Doing these things may get
you publically humiliated and your code rewritten without notice.
