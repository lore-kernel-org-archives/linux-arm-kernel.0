From: zonque@gmail.com (Daniel Mack)
Date: Fri, 05 Jul 2013 01:02:25 +0200
Subject: Appended DTB files for multi-machine kernels
In-Reply-To: <201307042334.37161.arnd@arndb.de>
References: <51D5A938.30607@gmail.com> <20130704171148.GJ27646@sirena.org.uk>
 <201307042334.37161.arnd@arndb.de>
Message-ID: <51D5FF01.3060104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 04.07.2013 23:34, Arnd Bergmann wrote:
> On Thursday 04 July 2013, Mark Brown wrote:

>> Another way of skinning this would be for either the kernel to contain
>> a set of machine ID to compatible string mappings or for the device
>> trees for the boards to have an additional properties giving the machine
>> IDs that the boards match.  The kernel could then look for multiple DTBs
>> appended to the image and try to pick one based on ATAGs.
> 
> IIRC there is actually an unused field in the dtb header that could
> be used to match a board ID.

While that would help many users, it doesn't cover our case where
different board revisions require different DTBs to be loaded, depending
on the supplied ATAG.

I think I'll go for Nicolas Pitre's suggestion as first step. He's right
that's it's a hack anyway, and we're just dealing with legacy systems
here, and hence it might not even be worth caring too much about a
proper solution.


Thanks for all the answers,
Daniel
