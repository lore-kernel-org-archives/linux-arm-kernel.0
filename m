From: dhowells@redhat.com (David Howells)
Date: Mon, 04 Nov 2013 22:03:44 +0000
Subject: [PATCH trivial] include: uapi: standard all files' macro prefix
 and suffix, excluding "linux/" sub-directory
In-Reply-To: <51FB6216.6010008@asianux.com>
References: <51FB6216.6010008@asianux.com>
Message-ID: <11907.1383602624@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chen Gang <gang.chen@asianux.com> wrote:

> For "include/uapi/*", excluding "linux/" sub-directory, let all files'
> macro prefix match the standard format, and give related stand comments
> for their macro suffix.
> 
> The related standard format is:
> 
>   "_SUBDIRNAME_SUBDIRNAME[_SUBDIRNAME]_FILENAME" (1st _SUBDIRNAME is _UAPI), and use '_' instead of '.' and '-'.

I strongly recommend _against_ this without very careful consideration.
Userspace sometimes depends on the name in the guard macro:-/

David
