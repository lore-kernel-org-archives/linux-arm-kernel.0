From: andy@warmcat.com (Andy Green)
Date: Wed, 24 Mar 2010 14:38:31 +0000
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <20100324140101.GC26453@rakim.wolfsonmicro.main>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
	<4BA9D93E.50705@warmcat.com>
	<20100324113241.GC5831@opensource.wolfsonmicro.com>
	<4BAA017D.70503@warmcat.com>
	<20100324140101.GC26453@rakim.wolfsonmicro.main>
Message-ID: <4BAA23E7.9010100@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/10 14:01, Somebody in the thread at some point said:

>>> The only system I'm aware of which had any stuff like this was the
>>> GTA02.  I never investigated to figure out why the code there was doing
>>> what it was.
>
>> I wouldn't be so quick to assert that, you do not know all the code
>> out there in order to tell.
>
> I really am very sure that nobody has ever reported any issues here -

There's plenty of out-of-tree code.  I'm not trying to blame you for 
something, just it's too strong to say there's no problem here because 
you personally didn't see it in your neck of the woods (especially when 
I spent many weeks fighting exactly that on GTA02).

There problem's generic -->

> Until we have real systems we can look at I'm not really sure it's worth
> worrying about since there's a risk of desigining something that doesn't
> fit well with what people actually need, and there's always the chance
> that something like the device layer will solve the problem before
> anyone notices.

No I agree after both Marek's and your discussion (and remembering the 
other races I had seen), the problem is bigger than regulator API and 
the device layer would be the right place.

You're right someone needs to bring it up elsewhere.

-Andy
