From: joshua.clayton@uniwest.com (Joshua Clayton)
Date: Wed, 18 Nov 2015 09:38:03 -0800
Subject: rtc test 2
In-Reply-To: <564A1679.9070700@uniwest.com>
References: <2038851.J2zvFTXF8S@jclayton-pc> <6767947.aE8xIVpPRR@jclayton-pc>
 <564A1679.9070700@uniwest.com>
Message-ID: <3458577.MLHbIx9t1o@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Monday, November 16, 2015 09:46:33 AM Steve Eagan wrote:
> 
> I agree, setting to the opposite extreme is a good idea
> 
> On Friday, November 13, 2015 03:45:56 PM Joshua Clayton wrote:
> > rtc on 109 was set to the maximum adjustment value 273420 parts per
> > billion.
> > synchronized at 3:39:00 pm Today.
> > I'll check it again on Monday to see how far it has drifted.
> > Monday November 16 at 7:42:00 on my PC clock, the rtc on109 reads 07:40:36
> > 
> > My expectation was that the time would be ahead, instead it is 1 minute 24
> > seconds behind. Perhaps I misunderstand which way the adjustment pushes
> > the
> > clock?
> > 
> > On the bright side, the effect is pronounced. It seemws to support the
> > idea
> > that it is doing something.
> > 
> > Any thoughts on a value to try next? My first thought is to set to the
> > opposite extreme... Going ahead with that.
> > 
> > OK then. Setting adjust to
> > 
> > root at evi:~# cat /sys/class/rtc/rtc0/device/adjust
> > -277760
> > root at evi:~# cat /sys/class/rtc/rtc0/device/d
> > 0xc0
> > 
> > Monday November 16 at 7:51:00  Clock syncronized to my PC clock.

Tested rtc this morning
November 18 7:45:00 AM, instrument 109 shows November 18 7:45:03
So the adjusment has made the clock fast. The adjustment is in the opposite direction previously thought.

3 seconds * 1 billion / 172440 seconds = 17397 parts per billion

 
I am going to try another setting:

if the setting -277760 yields 17397....

I'm kind of in a boggle.
-277760 + 17397 would be -260363... the closest available value is -260400

synchronized November 18 09:33:00

root at evi:~# cat /sys/class/rtc/rtc0/device/d
0xc4
root at evi:~# cat /sys/class/rtc/rtc0/device/adjust 
-260400

Since my understanding of the math involved was upside down, I have little confidence in the above figures (except the empirical numbers),
but the testing will continue.

One thing to think about: The closer we get, the longer it will take to make a good measurement. Data is only available at one second
granularity 

-- 
Joshua Clayton
Software Engineer
UniWest
122 S. 4th Avenue
Pasco, WA 99301
(509) 544-0720
