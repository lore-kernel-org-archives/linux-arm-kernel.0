From: isubramanian@apm.com (Iyappan Subramanian)
Date: Wed, 11 Jun 2014 18:59:47 -0700
Subject: [PATCH v5 4/4] drivers: net: Add APM X-Gene SoC ethernet driver
 support.
In-Reply-To: <20140605.004555.658378024391856482.davem@davemloft.net>
References: <1401737954-26152-1-git-send-email-isubramanian@apm.com>
 <1401737954-26152-5-git-send-email-isubramanian@apm.com>
 <20140605.004555.658378024391856482.davem@davemloft.net>
Message-ID: <CAKh23F=F3YOc830v45FavdToOvHEXO7tw6duRvn7-32GUb6cjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 5, 2014 at 12:45 AM, David Miller <davem@davemloft.net> wrote:
> From: Iyappan Subramanian <isubramanian@apm.com>
> Date: Mon,  2 Jun 2014 12:39:14 -0700
>
>> +     netdev_err(ndev, "LERR: %d ring_num: %d ", status, ring->num);
>> +     switch (status) {
>> +     case HBF_READ_DATA:
>> +             netdev_err(ndev, "HBF read data error\n");
>> +             break;
>
> This is not really appropriate.
>
> We have statistics like the ones you are incrementing in this
> function as the mechanism people can use to learn what events
> happened on an interface, and how many times they happened.
>
> Therefore, emitting a log message for each one of those events too is
> not necessary.
>
> We don't emit a netdev_err() for every packet that the IPv4 stack
> drops due to a bad checksum, for example.
>
> Please get rid of this.

Sure.  I will remove the error message prints and clean up the function.

>
