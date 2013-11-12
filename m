From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Tue, 12 Nov 2013 14:09:01 +0000
Subject: [PATCH RFC 07/10] PM / wakeup : Introduce device_child_may_wakeup
In-Reply-To: <4093206.klj58BXQv3@vostro.rjw.lan>
References: <1384264311-7308-1-git-send-email-srinivas.kandagatla@st.com>
 <1384264377-7609-1-git-send-email-srinivas.kandagatla@st.com>
 <4093206.klj58BXQv3@vostro.rjw.lan>
Message-ID: <5282367D.1090705@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/13 14:20, Rafael J. Wysocki wrote:
>>  
>> > +/* callback for device_child_may_wakeup */
>> > +static int __device_child_may_wakeup(struct device *dev, void *c)
>> > +{
>> > +	return device_may_wakeup(dev);
>> > +}
> This doesn't have anything to do with children in principle, so please call
> it differently.  Something like device_may_wakeup_cb() would work for me (and
> then you may not need the comment even).

Thanks Rafael, I will fix this in next version.
> 
> Thanks!
> 
>> > +
>> > +/**
