From: mpeg.blue@free.fr (Mason)
Date: Thu, 20 Nov 2014 22:41:35 +0100
Subject: Looking for good references for ARM driver development
In-Reply-To: <546CCBF6.7070607@gmail.com>
References: <546C920A.7060800@free.fr> <546CCBF6.7070607@gmail.com>
Message-ID: <546E600F.8020704@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/2014 17:57, Victor Ascroft wrote:

> On 11/19/2014 06:20 PM, Mason wrote:
> 
>> Are there more recent technical references, as good as LDD3, that
>> cover "modern" aspects of kernel development?
> 
> The LDD3 is one of the best there is. A fourth edition is supposed
> to come out sometime next year.
> http://www.amazon.com/Linux-Device-Drivers-Jessica-McKellar/dp/1449371612

That's the best news I've heard this week!
Hope Jonathan gets well and lives happily ever after.

>> How do I "leave device registration for the system infrastructure"?
>> Where should I put that code?
>> Is it a good idea to separate device registration and driver registration
>> in the case of a SoC, where the device is embedded in the SoC and is not
>> "hot-plugged" (or anything-plugged for that matter, it's just "there").
> 
> For understanding this you need to understand how the platform infrastructure
> works and why is it used.
> http://lwn.net/Articles/448499/
> http://lwn.net/Articles/448502/
> and go through some of the relevant drivers.

More of Jon's (great) work ;-)
Will definitely read these articles carefully.

>> 3) Why is the function used to "destroy a platform device" named
>> platform_device_put? Why put?
>> Put on a list of things to destroy at a later time?
> 
> This should be more clear once you go through LDD3.

I'm coming up empty.
AFAICT, it's unrelated to the _put_user* family of functions.
I see that it has something to do with ref count decrement.
[more reading...]
Something about kref.
https://lwn.net/Articles/336224/

They mention "put" but not *why* it's called "put".
Is it related to Dijkstra's P and V for semaphores?
https://cs.nyu.edu/~yap/classes/os/resources/origin_of_PV.html
Still confused...

Regards.
