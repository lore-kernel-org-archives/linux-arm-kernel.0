From: jeffv@google.com (Jeffrey Vander Stoep)
Date: Tue, 18 Aug 2015 14:42:44 -0700
Subject: Prevent list poison values from being mapped by userspace processes
Message-ID: <CABXk95C=CpeL4mNmS6-jJ-0bMJf6fawwfs6DM1-p8FctTEFbpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

List poison pointer values point to memory that is mappable by
userspace. i.e. LIST_POISON1 = 0x00100100 and LIST_POISON2 =
0x00200200. This means poison values can be valid pointers controlled
by userspace and can be used to exploit the kernel as demonstrated in
a recent blackhat talk:
https://www.blackhat.com/docs/us-15/materials/us-15-Xu-Ah-Universal-Android-Rooting-Is-Back-wp.pdf

Can these poison values be moved to an area not mappable by userspace
on 32 bit ARM?

Thanks,
Jeff
