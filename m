From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 05 Nov 2013 11:34:26 +0800
Subject: [PATCH trivial] include: uapi: standard all files' macro prefix
 and suffix, excluding "linux/" sub-directory
In-Reply-To: <11907.1383602624@warthog.procyon.org.uk>
References: <51FB6216.6010008@asianux.com>
 <11907.1383602624@warthog.procyon.org.uk>
Message-ID: <52786742.1080509@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2013 06:03 AM, David Howells wrote:
> Chen Gang <gang.chen@asianux.com> wrote:
> 
>> For "include/uapi/*", excluding "linux/" sub-directory, let all files'
>> macro prefix match the standard format, and give related stand comments
>> for their macro suffix.
>>
>> The related standard format is:
>>
>>   "_SUBDIRNAME_SUBDIRNAME[_SUBDIRNAME]_FILENAME" (1st _SUBDIRNAME is _UAPI), and use '_' instead of '.' and '-'.
> 
> I strongly recommend _against_ this without very careful consideration.

All first-send interface related patches are not for applying, they are
only for discussing.


> Userspace sometimes depends on the name in the guard macro:-/
> 

"the guard macro" is only for prevent itself from being included by
multiple times (an id used by itself -- like a handle), it is not an id
to let other files know about it (it is not a normal using way).

If we really want to check "a file id", normally we will check some
macros which already defined in this header file (or in some scripts,
check file path) instead of checking "its file id"

Using the standard format can be sure of file id is always unique in the
future, and it also can let our interface (Linux's address) more cleaner
and beautiful.


Hmm.. do you mean as an interface, if really have unusual(incorrect)
using ways, we have to bear and compatible with them -- although the
interface never says "it will not be changed in the future".


Thanks.
-- 
Chen Gang
