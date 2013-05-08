From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 9 May 2013 00:03:05 +0800
Subject: [RFC 1/8] serial:st-asc: Add ST ASC driver.
In-Reply-To: <20130508155301.GB27273@kroah.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081634.43498.arnd@arndb.de> <20130508153459.GA17186@kroah.com>
 <20130508154057.GB3041@game.jcrosoft.org> <20130508155301.GB27273@kroah.com>
Message-ID: <B5A00B86-5332-427E-A82A-5B71EC0979A8@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 8, 2013, at 11:53 PM, Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, May 08, 2013 at 05:40:57PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 08:34 Wed 08 May     , Greg KH wrote:
>>> On Wed, May 08, 2013 at 04:34:43PM +0200, Arnd Bergmann wrote:
>>>>> +#define ASC_MAJOR		204
>>>>> +#define ASC_MINOR_START		40
>>>> 
>>>> I don't know what the current policy is on allocating major/minor numbers,
>>>> but I'm sure you cannot just reuse one that is already used.
>>> 
>>> I agree, why are you trying to create a new tty device name?  Can't you
>>> use the existing ttyS name and minor number as you will not have any
>>> other type of serial device on this system?
>> 
>> Greg on ST STB for more than 10 years we use ttyASC I'll prefer ttySx
> 
> For 10+ years you have had an out-of-tree serial driver?
yes ST have it out of tree for very long time even I puts them to come mainline

>  What
> major/minor numbers did you use for it?

http://git.stlinux.com/?p=havana/com.st.havana.kernel.git;a=blob;f=drivers/serial/stm-asc.h;h=79e003ffeb21df55a6af94774fc9c4b3d8de18e9;hb=HEAD

  52 #define ASC_MAJOR               204
  53 #define ASC_MINOR_START         40

same as in this patch

> 
>> on the DTB SoC you have one one IP present the st,asc
> 
> I don't understand, what do you mean by this?
> 
> confused,

just mention there is not hardware reason to not use the generic ttySx in place of ttyAS
as we have only one IP that handle serial on this family of SoC

personally I'll switch to ttySx

Best Regards,
J.
